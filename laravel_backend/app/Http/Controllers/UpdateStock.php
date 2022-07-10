<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UpdateStock extends Controller
{
    public function updateStock($id, Request $request){
        $data = array();
        $validatedData = $request->validate([
            'stock' => 'required',
        ]);
        $data['stock'] = $validatedData['stock'];
        $insert = DB::table('produits')->where('id',$id)->update($data);
        return response()->json("Stock du Produit Modifié");
    }
}
