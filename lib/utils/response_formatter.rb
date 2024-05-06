module ResponseFormatter
    def self.success(message, data, code)
        { code: code, message: message, data: data}
    end

    def self.paginate(message, data, meta, code)
        { code: code, message: message, data: data, meta: meta}
    end
  
    def self.error(message, code, errors = nil)
        response = { code: code, message: message, error: true }
        response[:errors] = errors if errors.present?
        response
    end
end