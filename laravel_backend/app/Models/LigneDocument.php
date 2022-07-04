<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LigneDocument extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_doc','refProd','nomProd','qteProd','prixProd','tvaProd'
    ];
}
