Bundler.require
require "tempfile"
require "open-uri"

class BGM
  def each(term)
    tracks = ITunesSearchAPI.search(term: term, country: "JP", media: "music", limit: 8)
    tracks.each{|track|
      yield lookup track
    }
  end

  def info(item)
    puts "#{item['artistName']} - #{item['trackName']} #{item['collectionViewUrl']}"
  end

  def play(item)
    file = download(item)

    if async?
      system "afplay #{file.path} &"
    else
      system "afplay #{file.path}"
    end
  rescue Interrupt
    nil
  end

  def async?
    @async
  end

  def async!
    @async = true
  end

  protected

  def lookup(track)
    ITunesSearchAPI.lookup(:id => track['trackId'], :country => "JP")
  end

  def download(item)
    content = open(item['previewUrl']).read

    file = Tempfile.new('bgm')
    file.print content
    file.close
    file
  end
end

term = ARGV.shift

unless term
  warn "usage: #{ $0 } TERM"
  exit 1
end

bgm = BGM.new


if ARGV.include? '--async'
  bgm.async!
end

bgm.each(term) {|track|
  bgm.info track
  bgm.play track
}
sleep 1
