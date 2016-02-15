# Project 4 - *Tweety*

**Tweety** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **WIP** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] Retweeting and favoriting should increment the retweet and favorite count. (does not update the server only increments displayed count)

The following **optional** features are implemented:

- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. (does not update the server only decrements displayed count)
- [x] User can pull to refresh.

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!
    - [x] Displayed time text in a really nice way (s, m, h, d, y)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Programmatically changing the color of different objects
2. Updating retweet/favorite by sending it to twitter server using the api

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://imgur.com/UM0fbYZ.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

I had a really bad time with displaying the tweets because I forgot to reloadData() of the tableView leading to an hour of waste, anyways lesson learned.

## License

    Copyright 2016 Deep Patel (DGh0st)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
