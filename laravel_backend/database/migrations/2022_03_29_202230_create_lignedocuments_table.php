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
        Schema::create('lignedocuments', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('id_doc');
            $table->unsignedBigInteger('id_prod');
            $table->string('refProd');
            $table->string('nomProd');
            $table->float('qteProd');
            $table->float('prixProd');
            $table->timestamps();

            $table->foreign('id_doc')->references('id')->on('documents');
            $table->foreign('id_prod')->references('id')->on('produits');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lignedocuments');
    }
};
