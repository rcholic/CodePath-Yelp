# Project 2 - *Yelp Helper*

**Yelp Helper** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Search results page
   - [x] Table rows should be dynamic height according to the content height.
   - [x] Custom cells should have the proper Auto Layout constraints.
   - [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [x] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [x] The filters table should be organized into sections as in the mock.
   - [x] You can use the default UISwitch for on/off states.
   - [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results.
   - [ ] Implement map view of restaurant results.
- [ ] Filter page
   - [ ] Implement a custom switch instead of the default UISwitch.
   - [ ] Distance filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [ ] Implement the restaurant detail page.

The following **additional** features are implemented:

- [x] Rewrote the Yelp API Service using **SwiftyJSON** and **ObjectMapper** for efficient JSON parsing.
- [x] Set the global style/color in the **AppDelegate.swift** file so as to avoid setting up the navigation bar tint color in individual View Controller: saves code
- [x] Collapsible dropdown views for single selection of *Distance* and *Sort by* in the Filters screen
- [x] Search activity indicator when the *UISearchBar* is performing search
- [x] Using a throttle mechanism to control the frequency of API calls to Yelp. The search is delayed by 0.5 second when text is changed in the search bar, this improves user experience and also reduces the unnecessary number of API calls for every single text change event
- [x] Search results pagination using Pull-to-refresh

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Retrieving the app user's location and use that as the default location for the search, which the user can override
2. Alternative way of doing the layout rather than the Auto Layout which I found a little bit unwieldy to use, with less control in my hands.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![](./screencast/screen1.gif)

![](./screencast/screen2.gif)


## Notes

The only challenge I encountered is the mistyping of the "distance" field in the Yelp API response. I first thought it was String type, but I keep seeing nothing showing up for the distance label in the UITableView cell. It look me hours to find out the cause. It should be *Float* type, but I kept thinking why the distance UILabel got pushed out of the cell - duh!

## License

The MIT License
Copyright (c) [Tony Wang] https://github.com/rcholic/CodePath-Yelp

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
