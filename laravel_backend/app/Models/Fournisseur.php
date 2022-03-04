<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Fournisseur extends Model
{
    use HasFactory;
    protected $fillable = [
        'nom','prenom','tel','pays','ville','adresse','mf','cin','raisonSociale','exoTVA','dateDebutExo','dateFinExo','remise','pointFidelite','solde','timbreFiscal'
    ];
}
