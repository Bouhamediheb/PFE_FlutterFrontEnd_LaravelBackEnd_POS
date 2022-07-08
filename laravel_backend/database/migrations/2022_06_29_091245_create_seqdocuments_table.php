<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('seqdocuments', function (Blueprint $table) {
            $table->id();
            $table->integer('seq_id');
            $table->timestamps();
        });

        DB::table('seqdocuments')->insert([
            ['id' => 1, 'seq_id' => 0,],
            ['id' => 2, 'seq_id' => 0,],
            ['id' => 3, 'seq_id' => 0,],
            ['id' => 4, 'seq_id' => 0,],
            ['id' => 5, 'seq_id' => 0,],
            ['id' => 6, 'seq_id' => 0,],
        ],);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('seqdocuments');
    }
};
