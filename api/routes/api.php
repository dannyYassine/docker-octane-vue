<?php

use App\Jobs\ProcessPodcast;
use App\Models\User;
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
    try {
        return response([
            'data' => \Illuminate\Support\Facades\DB::table('users')
                ->get()
        ]);
    } catch (\Throwable $e) {
        return response([
            'error' => [
                'message' => $e->getMessage(),
                'trace' => $e->getTrace()
            ]
        ]);
    }
});

Route::get('/users/concurrent', function () {
    ProcessPodcast::dispatch();

    [$users, $moreUsers] = Octane::concurrently([
        fn () => User::all(),
        fn () => User::all()
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
    $user = \App\Models\User::factory($request->all())->create();

    return response([
        'data' => $user
    ]);
});
