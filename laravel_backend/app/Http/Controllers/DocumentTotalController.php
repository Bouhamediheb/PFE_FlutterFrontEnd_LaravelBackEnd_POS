<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use App\Models\Document;

class DocumentTotalController extends Controller
{
    public function updateTotalDocument(Request $request,$id)
    {
        $data=array();
        $data['totalDoc'] = $request->totalDoc;
        $insert = DB::table('documents')->where('id',$id)->update($data);
        return response()->json('Document Modifié');
    }
}
