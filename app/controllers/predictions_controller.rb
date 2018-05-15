class PredictionsController < ApplicationController

  def index
    @predictions = Prediction.active.includes(:coin)
  end
end
