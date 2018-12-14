<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
  $date = DateTime::createFromFormat('d-m-Y H:i:s', '1544496695');
  var_dump($date);
  return $router->app->version();
});

$router->group(['prefix' => 'api'], function () use ($router) {
  $router->get('results',  ['uses' => 'ResultsController@showAllResults']);

  $router->get('results/{id}', ['uses' => 'ResultsController@showOneResult']);

  $router->post('results', ['uses' => 'ResultsController@create']);

  $router->delete('results/{id}', ['uses' => 'ResultsController@delete']);

  $router->put('results/{id}', ['uses' => 'ResultsController@update']);
});