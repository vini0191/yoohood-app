class InvitesController < ApplicationController


  # def create
  #   @invite = Invite.new(invite_params)
  #   @invite.user = current_user
  #   @invite.event = Event.find(params[:event_id])
  #   if @invite.save
  #     redirect_to event_path(@invite.event)
  #   else
  #     render :new
  #   end
  # end

  def guest
    raise
    @invite = Invite.new(invite_params)
    @invite.event = Event.find(params[:event_id])
    @invite.send_invite_mail(@invite.guest_email)
    redirect_to event_path(@invite.event)
  end

  def new
  end

  def show

  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def invite_params
    params.require(:invite).permit(:guest_name, :guest_email)
  end
end
