<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\User;

class RoleController extends Controller
{
    public function attribuerRole(Request $request, $id){
        $data = array();
        $validatedData = $request->validate([
            'role' => 'required|integer|between:1,3',
        ]);
        $data['role'] = $validatedData['role'];
        $insert = DB::table('users')->where('id',$id)->update($data);
        return response()->json("Rôle de l'Utilisateur Modifié");
    }
}
