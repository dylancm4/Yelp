# Yelp

Yelp is a Yelp search app for iOS submitted as [Assignment #2](https://github.com/dylancm4/Yelp) for the CodePath October 2016 iOS bootcamp.

Time spent: **23** hours

## User Stories

**Required** functionality:

Businesses page:
* [x] Table rows should be dynamic height according to the content height.
* [x] Custom cells should have the proper Auto Layout constraints.
* [x] Search bar should be in the navigation bar.

Filters page:
* [x] The filters you should have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
* [x] The filters table should be organized into sections as in the mock.
* [x] Use the default UISwitch for on/off states.
* [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.

**Optional** functionality:

Businesses page:
* [x] Infinite scroll for business results.
* [ ] Implement map view of business results.
* [ ] Implement a business details page.

Filters page:
* [ ] Implement a custom switch for on/off states.
* [x] Distance filter should expand as in the real Yelp app.
* [X] Categories should show a subset of the full list with a "See All" row to expand.

**Additional** functionality

* [x] User sees loading state while waiting for Yelp API.
* [x] Images fade in as they are loading.
* [x] Customized the navigation bar.

## Walkthrough

![Video Walkthrough](YelpDemo.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Open-Source Libraries Used
AFNetworking
BDBOAuth1Manager
MBProgressHUD

## License

Copyright [2016] Dylan Miller

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
