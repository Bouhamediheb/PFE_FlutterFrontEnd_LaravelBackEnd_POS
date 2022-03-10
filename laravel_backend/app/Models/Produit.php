<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Produit extends Model
{
    use HasFactory;
    protected $fillable = [
        'refProd', 'nomProd', 'prixAchat', 'prixVente', 'descriptionProd', 'TVA'
    ];
}
