<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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
