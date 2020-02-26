class Api::V1::TopicsController < Api::V1::BaseController

  def index
    topics = Topic.all
    all_topics = topics.collect{|topic| topic_obj(topic)}
    response = { auth_token: auth_token, topics: all_topics}
    json_response(response)
  end

  private

  def topic_obj(topic)
    topic.attributes.merge(articles: topic.articles.collect{|article| article.article_obj })
  end

end
