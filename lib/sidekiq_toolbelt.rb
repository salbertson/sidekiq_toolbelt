require "sidekiq_toolbelt/version"

module SidekiqToolbelt
  extend self

  def counts(queue: :default)
    counts = {}

    Sidekiq::Queue.new(queue).each do |job|
      if counts[job.klass].nil?
        counts[job.klass] = 1
      else
        counts[job.klass] += 1
      end
    end

    pp counts.sort_by {|k,v| -v}.to_h
  end

  def kill(job, queue: :default)
    Sidekiq::Queue.new(queue).each do |job|
      job.delete if job.klass.starts_with?(job)
    end
  end

  def kill_by_error(error, queue: :default)
    Sidekiq::Queue.new(queue).each do |job|
      job.delete if job.item['error_class'] == error
    end
  end

  def kill_retries(job)
    Sidekiq::RetrySet.new.each do |job|
      job.delete if job.klass.starts_with?(job)
    end
  end

  def kill_retries_by_error(error)
    Sidekiq::RetrySet.new.each do |job|
      job.delete if job.item['error_class'] == error
    end
  end

  def clear(*jobs, queue: :default)
    loop do
      # update and reuse #kill?
      Sidekiq::Queue.new(:default).each do |job|
        if jobs.include? job.klass
          job.delete
        end
      end
      puts 'clearing...'
      sleep 5
    end
  end
end
