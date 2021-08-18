<?php

use Illuminate\Http\Request;
use Illuminate\Support\Env;
use Illuminate\Support\Facades\Route;
use Laravel\Octane\Facades\Octane;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/health', function () {
    return response([
        'data' => 'Alive'
    ]);
});

// Octane::get('/weather/{city}', function (Request $request) {
//     $city = $request->route()->parameter('city');
//     $appId = Env::get('WEATHER_API_KEY');

//     $weatherData = file_get_contents("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId");

//     return response([
//         'data' => json_decode($weatherData)
//     ]);
// });

Route::get('/phpinfo', function (Request $request) {
    phpinfo();
});

Route::get('/weather/{city}', function (Request $request) {

    $getData = function () use ($request) {
        $city = $request->route()->parameter('city');
        $appId = Env::get('WEATHER_API_KEY');

        $weatherData = file_get_contents("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId");

        return json_decode($weatherData);
    };

    return response([
        'data' => $getData()
    ]);
});

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/users', function () {
    $users = \App\Models\User::all();
    return response([
        'data' => $users
    ]);
});

Route::post('/users', function (Request $request) {
    $user = \App\Models\User::factory($request->all())->create();
    return response([
        'data' => $user
    ]);
});
