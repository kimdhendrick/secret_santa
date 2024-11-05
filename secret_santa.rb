#!/usr/bin/env ruby

COUPLES = [
  [:kim_hendrick, :david_madouros],
  [:karen_hendrick, :peter_hendrick],
  [:jill_harbin, :pete_harbin],
  [:monica_barnes],
  [:mitchell_barnes],
]
class SecretSanta
  def go
    taken = {}

    COUPLES.flatten.each do |participant|
      partners = COUPLES.select {|couple| couple.include?(participant)}.first

      candidates = COUPLES.flatten - partners - taken.keys

      assignment = candidates.sample

      raise 'Too bad, try again!' if assignment.nil?

      taken[assignment] = participant
    end

    taken.each do |santa, assignee|
      File.open("#{santa.to_s}.txt", 'w') do |file|
        file << <<-MSG
Dear #{santa.to_s.split('_').map(&:capitalize).first}, 

For Christmas this year, your Secret Santa assignment is #{assignee.to_s.split('_').map(&:capitalize).join(' ')}!
Sshhh! Don't tell!

Love,
Secret Santa Assigner
        MSG
      end
    end
  end
end

SecretSanta.new.go
