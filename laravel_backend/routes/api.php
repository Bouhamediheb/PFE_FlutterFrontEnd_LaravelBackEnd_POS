<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

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

Route::apiresource('/fournisseur','App\Http\Controllers\Api\FournisseurController');

Route::apiresource('/document','App\Http\Controllers\Api\DocumentController');

Route::apiresource('/produit','App\Http\Controllers\Api\ProduitController');

Route::apiresource('/lignedocument', 'App\Http\Controllers\LigneDocumentController');

Route::post('/register',[AuthController::class, 'register']);

Route::post('/login',[AuthController::class, 'login']);

Route::post('/me', [AuthController::class, 'me']);

Route::post('/logout',[AuthController::class, 'logout'])->middleware('auth:sanctum');

Route::post('/me', [AuthController::class, 'me'])->middleware('auth:sanctum');

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
