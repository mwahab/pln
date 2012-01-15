module ApplicationHelper
  def snippet(thought, wordcount=10) 
    thought.split[0..(wordcount-1)].join(" ") + (thought.split.size > wordcount ? "..." : "") 
  end 
end
