module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_consultant, :current_user

    def connect
      find_verified
    end

    protected

    def find_verified
      setup_user if verified_user
      setup_consultant if verified_consultant

      reject_unauthorized_connection unless [current_consultant, current_user].any?
    end

    def verified_user
      cookies.signed['user.expires_at'].present? &&
        cookies.signed['user.expires_at'] > Time.zone.now
    end

    def verified_consultant
      cookies.signed['consultant.expires_at'].present? &&
        cookies.signed['consultant.expires_at'] > Time.zone.now
    end

    def setup_consultant
      self.current_consultant = Consultant.find_by(id: cookies.signed['consultant.id'])
      logger.add_tags 'ActionCable', "#{current_consultant.model_name.name} #{current_consultant.id}"
    end

    def setup_user
      self.current_user = User.find_by(id: cookies.signed['user.id'])
      logger.add_tags 'ActionCable', "#{current_user.model_name.name} #{current_user.id}"
    end
  end
end