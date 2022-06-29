<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SequenceDocumentController extends Controller
{

    public function getSeqDocument($id){
        $seqDocument = DB::table('seqdocuments')->where('id', $id)->first();
        return response()->json($seqDocument);
    }

    public function updateSeqDocument($id) {
        $seq = DB::table('seqdocuments')->where('id', $id)->sum('seq_id');
        $seq = $seq + 1;
        $update = DB::table('seqdocuments')->where('id', $id)->update(['seq_id' => $seq]);
        return response()->json($seq);
    }
}