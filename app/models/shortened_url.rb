require 'aux'

class ShortenedUrl < ApplicationRecord
  extend Aux
  belongs_to :user

  validates :url, format: { with: scheme_check, message: "is not an url" }

  around_create :generate_url_key

  # Prepares the URL for the key
  # @param key [String]
  # @return [String] URL
  def self.url_for(key)
    url_key = extract_token(key)
    fetch_with_token(url_key)
  end

  # Creates the shortened URL
  # @param shortened_url [ShortenedUrl]
  # @return [ShortenedUrl, NilClass]
  def self.generate(shortened_url)
    begin
      generate!(shortened_url.url, shortened_url.user)
    rescue => e
      logger.info(e)
      nil
    end
  end

  # Increases the URL usage count
  def used!
    self.class.increment_counter(:click_count, id)
  end

  def to_param
    url_key
  end

  private

  def self.extract_token(token)
    /^([#{Regexp.escape(char_set.join)}]*).*/.match(token)[1]
  end

  def self.fetch_with_token(url_key)
    shortened_url = where(url_key: url_key).first

    url = if shortened_url
      shortened_url.used!
      shortened_url.url
    else
      '/'
    end

    url
  end

  def self.generate!(target_url, user)
    if target_url.is_a?(self)
      if target_url.user == user
        target_url
      else
        generate!(target_url.url, user: user)
      end
    else
      cleaned_url = clean_url(target_url)
      user.shortened_urls.where(url: cleaned_url).first_or_create
    end
  end

  def generate_url_key(retries = 5)
    begin
      self.url_key = self.class.url_key_candidate
    end while self.class.unscoped.exists?(url_key: url_key)

    yield
  rescue ActiveRecord::RecordNotUnique
    if retries <= 0
      raise
    else
      retries -= 1
      retry
    end
  end
end
