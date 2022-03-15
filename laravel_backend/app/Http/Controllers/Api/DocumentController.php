<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DB;
use App\Models\Document;

class DocumentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $document = DB::table('documents')->get();
        return response()->json($document);
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
            'type' => 'required|numeric',
            'numDoc' => 'required|numeric',
            'dateDoc',
            'totalDoc',
            'enLigne',
            'timbreFiscal',
            'toucheStock',
            'operation',
        ]);
        $data= array();
        $data['type'] = $request->type;
        $data['numDoc'] = $request->numDoc;
        $data['dateDoc'] = $request->dateDoc;
        $data['totalDoc'] = $request->totalDoc;
        $data['enLigne'] = $request->enLigne;
        $data['timbreFiscal'] = $request->timbreFiscal;
        $data['toucheStock'] = $request->toucheStock;
        $data['operation'] = $request->operation;
        $insert = DB::table('documents')->insert($data);
        return response('Document Ajouté');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $show = DB::table('documents')->where('id',$id)->first();
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
        $data['type'] = $request->type;
        $data['numDoc'] = $request->numDoc;
        $data['dateDoc'] = $request->dateDoc;
        $data['totalDoc'] = $request->totalDoc;
        $data['enLigne'] = $request->enLigne;
        $data['timbreFiscal'] = $request->timbreFiscal;
        $data['toucheStock'] = $request->toucheStock;
        $data['operation'] = $request->operation;
        $insert = DB::table('documents')->where('id', $id)->update($data);
        return response('Document Modifié');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::table('documents')->where('id',$id)->delete();
        return response('Document Supprimé');
    }
}
