<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class StockProduitController extends Controller
{
    public function stockProduit($refProd)
    {
        $produit = DB::table('produits')->where('refProd', $refProd)->first();
        $stock = $produit->stock;
        return response()->json($stock);
    }
}