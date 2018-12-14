<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateResultsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('results', function (Blueprint $table) {
            $table->increments('id');
            $table->string('isp');
            $table->string('host_server');
            $table->string('host_distance');
            $table->decimal('ping');
            $table->decimal('download');
            $table->decimal('upload');
            $table->string('share_url');
            $table->string('network_interface');
            $table->string('operating_system');
            $table->string('latitude');
            $table->string('longitude');
            $table->string('postal_code');
            $table->string('city');
            $table->string('state');
            $table->string('country');
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
        Schema::dropIfExists('results');
    }
}
