<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DB;
use App\Models\Fournisseur;

class FournisseurController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $fournisseur = DB::table('fournisseurs')->get();
        return response()->json($fournisseur);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        
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
            'nom',
            'prenom',
            'tel' => 'required|min:8|max:16',
            'email' => 'required',
            'pays',
            'ville',
            'adresse' => 'required',
            'mf' => 'required',
            'cin',
            'raisonSociale' => 'required',
            'exoTVA',
            'dateDebutExo',
            'dateFinExo',
            'remise',
            'pointFidelite',
            'solde',
            'timbreFiscal'
        ]);
        $data=array();
        $data['tel'] = $request->tel;
        $data['email'] = $request->email;
        $data['pays'] = $request->pays;
        $data['ville'] = $request->ville;
        $data['adresse'] = $request->adresse;
        $data['mf'] = $request->mf;
        $data['raisonSociale'] = $request->raisonSociale;
        $data['exoTVA'] = $request->exoTVA;
        $data['dateDebutExo'] = $request->dateDebutExo;
        $data['dateFinExo'] = $request->dateFinExo;
        $data['remise'] = $request->remise;
        $data['solde'] = $request->solde;
        $data['timbreFiscal'] = $request->timbreFiscal;
        $insert = DB::table('fournisseurs')->insert($data);
        return response('Fournisseur Ajouté');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $show = DB::table('fournisseurs')->where('id', $id)->first();
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
        $data = array();
        $data['tel'] = $request->tel;
        $data['email'] = $request->email;
        $data['pays'] = $request->pays;
        $data['ville'] = $request->ville;
        $data['adresse'] = $request->adresse;
        $data['mf'] = $request->mf;
        $data['raisonSociale'] = $request->raisonSociale;
        $data['exoTVA'] = $request->exoTVA;
        $data['dateDebutExo'] = $request->dateDebutExo;
        $data['dateFinExo'] = $request->dateFinExo;
        $data['remise'] = $request->remise;
        $data['solde'] = $request->solde;
        $data['timbreFiscal'] = $request->timbreFiscal;
        $insert = DB::table('fournisseurs')->where('id', $id)->update($data);
        return response('Fournisseur Modifié');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::table('fournisseurs')->where('id', $id)->delete();
        return response('Fournisseur Supprimé');
    }
}