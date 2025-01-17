# frozen_string_literal: true

class NotificationsHelper
  class << self
    include Rails.application.routes.url_helpers

    def notification_icon(notification)
      notification_icon_map = {
        new_answer: 'fa-file-alt',
        new_comment: 'fa-comment',
        new_answer_comment: 'fa-comment',
        new_answer_like: 'fa-heart'
      }

      notification_icon_map[notification.kind.to_sym]
    end

    def message(notification)
      params = send("#{notification.kind}_params", notification.resource)
      I18n.t("#{notification.kind}_html", scope: [:notifications], **params)
    end

    def new_answer_params(resource)
      {
        user: resource.user,
        user_path: user_path(resource.user),
        answer_path: resume_path(resource.resume, anchor: "answer-#{resource.id}")
      }
    end

    def new_comment_params(resource)
      {
        user: resource.user,
        user_path: user_path(resource.user),
        comment_path: resume_path(resource.resume, anchor: "comment-#{resource.id}")
      }
    end

    def new_answer_comment_params(resource)
      {
        user: resource.user,
        user_path: user_path(resource.user),
        answer_comment_path: resume_path(resource.resume, anchor: "answer_comment-#{resource.id}")
      }
    end

    def new_answer_like_params(resource)
      {
        user: resource.user,
        user_path: user_path(resource.user),
        answer_path: resume_path(resource.resume, anchor: "answer-#{resource.answer.id}")
      }
    end
  end
end
