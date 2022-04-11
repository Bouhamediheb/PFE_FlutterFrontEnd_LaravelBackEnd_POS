<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use App\Models\Produit;

class ProduitStockController extends Controller
{
    public function updateStock(Request $request, $refProd)
    {
        $stock = DB::table('produits')->where('refProd', $refProd)->get('stock');
        $plucked = $stock->pluck('stock');
        $mirzaba = $request->stock;
        $nouveauStock = $plucked[0] + $mirzaba;
        $data= array();
        $data['stock'] = $nouveauStock;
        $insert=DB::table('produits')->where('refProd',$refProd)->update($data);
        return response()->json("Quantité Produit Modifié");
    }
}
