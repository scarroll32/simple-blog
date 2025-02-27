# http://localhost:3000/turbo/ios/path_configuration

module Turbo
  module Ios
    class PathConfigurationsController < ActionController::Base
      def show
        render json: {
            settings: {},
            rules: [
              {
                patterns: [
                  "/new$",
                  "/edit$",
                  "/users/sign_in"
                ],
                properties: {
                  context: "modal"
                }
              }
            ]
          }
      end
    end
  end
end
