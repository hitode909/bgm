# bgm.rb

Music Player

## PLAY DUBSTEP

```
bundle install
bundle exec -- ruby bgm.rb dubstep
```

## SET PLAYBACK RATE

```
bundle exec -- ruby bgm.rb dubstep --rate 0.5
```

## PLAY ALL TRACKS AT ONCE

```
bundle exec -- ruby bgm.rb dubstep --async
```

## HOW IT WORKS

bgm.rb uses [iTunes Store's Search API](https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html).
