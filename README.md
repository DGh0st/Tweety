# Project 4 - *Tweety*

**Tweety** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **8** hours spent in total

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

# Project 5 - *Tweety*

Time spent: **WIP** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] Profile page:
   - [x] Contains the user header view
   - [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [x] Home Timeline: Tapping on a user image should bring up that user's profile page
- [x] Compose Page: User can compose a new tweet by tapping on a compose button.

The following **optional** features are implemented:

- [x] When composing, you should have a countdown in the upper right for the tweet limit.
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately ~~without refetching the timeline from the network.~~
- [x] Profile Page
   - [x] Implement the ~~paging~~ view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [ ] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!
   - [x] Added an AlertSheet for when the user taps the logout button
   - [x] Retweet and Favorites now update the Twitter server

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Programmatically implementing a navigation bar that is not on top of the view but rather part of it
2. Implementing the pulling down of the profile page without requiring it to be turned into a tableView/scrollView if possible

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

Updating the server when retweet/unretweet and favorite/unfavorite was a bit difficult as keeping track of which state the user is currently in required some time to figure out.

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