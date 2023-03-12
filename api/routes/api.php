<?php

use App\Jobs\ProcessPodcast;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Env;
use Illuminate\Support\Facades\Route;
use Laravel\Octane\Facades\Octane;
use Illuminate\Support\Facades\Cache;

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

Route::get('/phpinfo', function (Request $request) {
    echo phpinfo();
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
    return response([
        'data' => User::get()
    ]);
});

Route::get('/redis/get', function () {
    return response([
        'data' => Cache::get('redis:key')
    ]);
});

Route::get('/redis/set', function () {
    $ttlSeconds = 10;
    $value = now();

    return response([
        'data' => Cache::put('redis:key', $value, $ttlSeconds)
    ]);
});

Route::get('/users/concurrent', function () {
    [$users, $moreUsers] = Octane::concurrently([
        fn () => User::get(),
        fn () => User::get()
    ]);

    return response([
        'data' => [$users, $moreUsers]
    ]);
});

Route::get('/job', function () {
    ProcessPodcast::dispatch();

    return response([
        'data' => 1
    ]);
});

Route::get('/users/create', function (Request $request) {
    $user = (new User($request->all()))->save();

    return response([
        'data' => $user
    ]);
});
