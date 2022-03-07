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
        Schema::create('documents', function (Blueprint $table) {
            $table->id();
            $table->integer('type');
            $table->string('numDoc')->nullable();
            $table->dateTime('dateDoc')->nullable();
            $table->float('totalDoc')->nullable();
            $table->boolean('enLigne')->nullable();
            $table->boolean('timbreFiscal')->nullable();
            $table->boolean('toucheStock')->nullable();
            $table->boolean('operation')->nullable();
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
        Schema::dropIfExists('documents');
    }
};
