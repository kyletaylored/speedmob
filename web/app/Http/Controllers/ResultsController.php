<?php

namespace App\Http\Controllers;

use App\Results;
use Illuminate\Http\Request;

class ResultsController extends Controller {

  /**
   * @return \Illuminate\Http\JsonResponse
   */
  public function showAllResults() {
    return response()->json(Results::all());
  }

  public function showOneResult($id) {
    return response()->json(Results::find($id));
  }

  public function create(Request $request) {
    $result = Results::create($request->json()->all());

    return response()->json($result, 201);
  }

  public function update($id, Request $request) {
    $result = Results::findOrFail($id);
    $result->update($request->json()->all());

    return response()->json($result, 200);
  }

  public function delete($id) {
    Results::findOrFail($id)->delete();

    return response('Deleted successfully.', 200);
  }
}