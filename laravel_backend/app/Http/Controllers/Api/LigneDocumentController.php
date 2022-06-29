<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\LigneDocument;

class LigneDocumentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $ligneDocument = DB::table('lignedocuments')->get();
        return response()->json($ligneDocument);
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
            'id_doc',
            'nomProd',
            'refProd',
            'qteProd',
            'prixProd',
        ]);

        $data=array();
        $data['id_doc'] = $request->id_doc;
        $data['refProd'] = $request->refProd;
        $data['nomProd'] = $request->nomProd;
        $data['qteProd'] = $request->qteProd;
        $data['prixProd'] = $request->prixProd;
        $insert = DB::table('lignedocuments')->insert($data);
        return response('Ligne Document Ajouté');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $show = DB::table('lignedocuments')->where('id', $id)->first();
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
        //
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
        $data['id_doc'] = $request->id_doc;
        $data['refProd'] = $request->refProd;
        $data['nomProd'] = $request->nomProd;
        $data['qteProd'] = $request->qteProd;
        $data['prixProd'] = $request->prixProd;
        $insert = DB::table('lignedocuments')->where('id',$id)->update($data);
        return response('Ligne Document Modifié');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::table('lignedocuments')->where('id', $id)->delete();
        return response('Ligne Document Supprimé');
    }
}
