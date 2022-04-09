<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class AuthController extends Controller
{
    public function register(Request $request)
{
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
]);

        $user = User::create([
            'name' => $validatedData['name'],
            'email' => $validatedData['email'],
            'password' => Hash::make($validatedData['password']),
       ]);

$token = $user->createToken('auth_token')->plainTextToken;

return response()->json([
                  'user' => $user,
                  'access_token' => $token,
                   'token_type' => 'Bearer',
]);
}

public function login(Request $request)
{
    $user = Auth::user();
if (!Auth::attempt($request->only('email', 'password'))) {
return response()->json([
    'user' => $user,
    'success' => false,
'message' => 'Informations de connexion invalide'
           ], 401);
       }

$user = User::where('email', $request['email'])->firstOrFail();

$token = $user->createToken('auth_token')->plainTextToken;

return response()->json([
          'user' => $user,
          'success' => true,
           'access_token' => $token,
           'token_type' => 'Bearer',
]);
}

public function logout(Request $res)
    {
      if (Auth::user()) {
        $user = Auth::user()->token();
        $user->revoke();

        return response()->json([
          'success' => true,
          'message' => 'Logout successfully'
      ]);
      }else {
        return response()->json([
          'success' => false,
          'message' => 'Unable to Logout'
        ]);
      }
     }

public function me(Request $request)
{
return $request->user();
} 

}
