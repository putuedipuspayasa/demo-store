class CategoryRepository
    def initialize(db = Category)
        @db = db
    end

    def fetch_all
        @db.all
    end

    def fetch_paginate(per_page: 15, page: 1, sort_field: 'id', sort_direction: 'desc', filter: {})
        offset = (page.to_i - 1) * per_page.to_i
        total_records = filter_query(filter).count.to_i
        total_pages = (total_records / per_page.to_i).ceil

        result = filter_query(filter)
          .order("#{sort_field} #{sort_direction}")
          .limit(per_page).offset(offset)

        [result, total_records, total_pages, per_page.to_i, page.to_i]
    end

    def get_by_uid(uid)
        @db.find_by(uid: uid)
    end

    def get_by_condition(filter)
        filter_query(filter).first
    end

    def store(param)
        row = @db.new(param)
        row.uid = SecureRandom.uuid
        row.save

        row
    end

    def update_by_uid(uid, attributes)
        row = @db.find_by(uid: uid)
        return false unless row

        row.update(attributes)
        true
    end

    def delete_by_uid(uid)
        row = @db.find_by(uid: uid)
        return false unless row

        row.destroy
        true
    end

    private

    def filter_query(filter)
        query = @db.all

        query = query.where(id: filter[:id]) if filter.key?(:id)
        query = query.where(uid: filter[:uid]) if filter.key?(:uid)
        query = query.where(name: filter[:name]) if filter.key?(:name)
        if filter.key?(:search) && filter[:search].present?
            query = query.where('LOWER(name) LIKE ? OR LOWER(description) LIKE ?', "%#{filter[:search].downcase}%", "%#{filter[:search].downcase}%")
        end
        query
    end
end