<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Produit;

class ProduitController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $produit = DB::table('produits')->get();
        return response()->json($produit);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'refProd' => 'required|unique:produits',
            'nomProd' => 'required',
            'prixAchatHT' => 'required',
            'prixVenteHT' => 'required',
            'descriptionProd',
            'stock' => 'required',
            'tvaProd' => 'required',
            'id_fournisseur',
           
        ]);
        $data= array();
        $data['refProd'] = $request->refProd;
        $data['nomProd'] = $request->nomProd;
        $data['prixAchatHT'] = $request->prixAchatHT;
        $data['stock'] = $request->stock;
        $data['descriptionProd']= $request->descriptionProd;
        $data['tvaProd'] = $request->tvaProd;
        $data['prixVenteHT'] = $request->prixVenteHT;
        $data['id_fournisseur'] = $request->id_fournisseur;
       
        $insert = DB::table('produits')->insert($data);
        return response('Produit Ajouté');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $show = DB::table('produits')->where('id', $id)->first();
        return response()->json($show);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {

    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $data= array();
        $data['refProd'] = $request->refProd;
        $data['stock'] = $request->stock;
        $data['nomProd'] = $request->nomProd;
        $data['prixAchatHT'] = $request->prixAchatHT;
        $data['descriptionProd']= $request->descriptionProd;
        $data['tvaProd'] = $request->tvaProd;
        $data['descriptionProd']= $request->descriptionProd;
        $data['id_fournisseur'] = $request->id_fournisseur;
        $insert = DB::table('produits')->where('id',$id)->update($data);
        return response()->json('Produit Modifié');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::table('produits')->where('id', $id)->delete();
        return response('Produit Supprimé');
    }
}
