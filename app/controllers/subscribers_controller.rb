# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  ##
  # GET /api/subscribers
  def index
    subscribers = Subscribers.all.by_recently_created
    total_records = subscribers.count
    limited_subscribers = subscribers[offset..limit]

    render json: {subscribers: limited_subscribers, pagination: pagination(total_records)}, formats: :json
  end

  def create
    subscriber = Subscriber.new(email: params[:email], firstname: params[:firstnamename], lastname: params[:lastname], status: "active")
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
