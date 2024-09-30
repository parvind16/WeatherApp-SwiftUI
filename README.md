# WeatherApp-SwiftUI

Weather is a simple app that displays weather in SwiftUI. I tried to combine all of them in one simple app to demonstrate how SwiftUI works. It shows asynchronous data fetch, binding and how to build user interfaces with SwiftUI.

## Feature

> - Custom, dynamic UI using SwiftUI
> - Expanded CurrentWeather model including apparent temperature and wind speed
> - Included 5-day forecast

### Screenshots

<div class="row" >
  <img src="https://github.com/mssengar/kotlinWeatherApp/blob/main/app/src/main/java/com/mss/weatherapp/asset/search_screen_shot.png" width="320">
  <img src="https://github.com/mssengar/kotlinWeatherApp/blob/main/app/src/main/java/com/mss/weatherapp/asset/weather_detail.png" width="320">
  <img src="https://github.com/mssengar/kotlinWeatherApp/blob/main/app/src/main/java/com/mss/weatherapp/asset/Cache.png" alt="Mountains" width="320">
</div>

### API

This project uses API data from [weatherapi.com](https://www.weatherapi.com/)

## Application Architecture 

![cleanarch](https://github.com/user-attachments/assets/0d501e75-f052-4b50-a5c5-0a64b3690a0d)

### Folder Structure

<img width="384" alt="architecture" src="https://github.com/user-attachments/assets/568d361e-4caa-4862-97c2-03d6e140fabb">

### Data Flow

![cleanflow](https://github.com/user-attachments/assets/d0a921cc-89fc-4bc7-8f46-5429423186ee)

## Prerequisites

Make sure you have the following installed:
- Xcode 14.x or later
- iOS 14.0 or later SDK

### Setup Instruction

You can setup/run the project in two ways - either by downloading the project and compiling locally using Xcode

#### Run the project locally

- Clone or download the project to your local machine
- Open the project in Xcode

### Testing

- The app includes unit tests for ViewModels.
- To run tests: Open the terminal in Xcode & run below command
  
## License
   ```bash
Copyright (C) 2024

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

