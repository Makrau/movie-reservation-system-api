module ParamsValidation
  extend ActiveSupport::Concern

  private

  def validate_pagination_params
    page = params[:page].to_i
    per_page = params[:per_page].to_i

    params[:page] = 1 if page < 1
    params[:per_page] = 10 if per_page < 1 || per_page > 100
  end

  def sanitize_string_param(param)
    return nil if param.blank?
    param.to_s.strip.gsub(/[^\w\s\-]/, "")
  end

  def sanitize_date_param(param)
    return nil if param.blank?
    Date.parse(param.to_s)
  rescue ArgumentError
    nil
  end

  def validate_id_param(id)
    return false unless id.to_i.positive?
    true
  end

  def validate_required_params(*params)
    missing_params = params.select { |param| params[param].blank? }
    if missing_params.any?
      render json: { error: "Parâmetros obrigatórios faltando: #{missing_params.join(', ')}" },
             status: :unprocessable_entity
      return false
    end
    true
  end
end
