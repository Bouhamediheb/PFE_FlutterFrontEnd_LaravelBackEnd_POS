<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('fournisseurs', function (Blueprint $table) {
            $table->id();
            $table->string('nom')->nullable();
            $table->string('prenom')->nullable();
            $table->string('tel')->nullable();
            $table->string('adresse')->nullable();
            $table->string('mf')->nullable();
            $table->string('cin')->nullable();
            $table->string('raisonSociale')->nullable();
            $table->boolean('exoTVA')->nullable();
            $table->dateTime('dateDebutExo')->nullable();
            $table->dateTime('dateFinExo')->nullable();
            $table->float('remise')->nullable();
            $table->float('pointFidelite')->nullable();
            $table->float('solde')->nullable();
            $table->float('timbreFiscal')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('fournisseurs');
    }
};
