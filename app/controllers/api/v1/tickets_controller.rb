class Api::V1::TicketsController < Api::V1::BaseController

  def create
    ticket = current_user.tickets.create!(title: params[:title], image: params[:image], purpose: params[:purpose])
    response = { message: "ticket created successfully", ticket: ticket, auth_token: auth_token }
    json_response(response)
  end

  def index
    tickets = current_user.tickets
    all_tickets = tickets.collect{|ticket| ticket_obj(ticket)}
    response = { auth_token: auth_token, tickets: all_tickets}
    json_response(response)
  end

  private

    def ticket_obj(ticket)
      ticket.attributes.merge(inquiries: ticket.inquiries.collect{|inquiry| inquiry.inquiry_obj}).except("updated_at")
    end
end
