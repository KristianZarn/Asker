module ApplicationHelper

  # Returns a full title on a per-page basis.
  def full_title(page_title)
    base_title = "Asker"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def add_dots(text, limit)
    if text.length > limit
      "#{text[0..limit]}..."
    else
      text
    end
  end
end
