# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  ##
  # GET /api/subscribers
  def index
    subscribers = Subscriber.all
    total_records = subscribers.count
    limited_subscribers = subscribers.limit(limit).offset(offset)

    render json: {subscribers: limited_subscribers, pagination: pagination(total_records)}, formats: :json
  end

  def create
    subscriber = Subscriber.create(email: params[:email], name: params[:name], status: "active")
    if subscriber.save
      render json: {message: "Subscriber created successfully"}, formats: :json, status: :created
    else
      render json: {message: "Error: Failed to subscribe!"}, formats: :json, status: :unprocessable_entity
    end
  end

  def update
    subscriber = Subscriber.find(params[:id])

    updated_status = (subscriber.status == "active") ? "inactive" : "active"

    if subscriber.update({status: updated_status})
      render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
    else
      render json: {message: "Error: Failed to update subscriber!"}, formats: :json, status: :unprocessable_entity
    end
  end
end
