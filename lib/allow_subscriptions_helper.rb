module RamonTayag
  module Gawing
    module VoteableHelper
      def link_to_vote(text, object, vote, options = {})
        options.merge!({:voteable_id => object, :voteable_type => object.class.name, :vote => vote})
        link_to(text, votes_path(options), :method => :post)
      end

      def link_to_vote_unless(boolean, text, object, vote, options = {})
        if boolean
          return link_to_vote(text, object, vote, options)
        else
          return text
        end
      end
    end
  end
end
