# RSpec Examples (RSpec Book, The Rails 3 Way, Custom)

################################################################################
# command line
# rspec --help (show help)
# rake -T spec (list all rspec-rails rake tasks)
# rspec spec (run all specs in spec folder)
# rspec spec/models/user_spec.rb (run only user_spec)
# rake spec:models (rails: run all model specs)

################################################################################
# configuration

# global before/after/around hooks
# (:each, :all, :suite)
RSpec.configure do |config|
  config.after :suite do
    Mongoid.master.collections.select do |collection|
      collection.name !~ /system/
    end.each(&:drop)
  end
end

# inclusion filter
RSpec.configure do |c|
  c.filter = { :focus => true }
end

describe "group" do
  it "example 1", :focus => true do

  end
end

# exclusion filter
RSpec.configure do |c|
  c.exclusion_filter = { :slow => true }
end

describe "group", :slow => true do
  it "example 1" do
  end
  it "example 2" do
  end
end

# lambda filter
require 'ping'
RSpec.configure do |c|
  c.exclusion_filter = {
    :if => lambda { |what|
      case what
      when :network_available
        !Ping.pingecho "example.com", 10, 80
      end
    }
  }
end

describe "network group" do
  it "example 1", :if => :network_available do
  end
  it "example 2" do
  end
end

################################################################################
# describe/context (describe for things, context (alias) for context)
describe User do

  context "#create" do

  end

end

################################################################################
# pending (instead of adding comment to disable example)
describe User do
  before { pending }

  it "should be successful" do

  end
end

describe "an empty array" do
  it "should be empty" do
    pending("bug report 18976") do
      [].should be_empty
    end
  end
end

################################################################################
# before, after, around (before(:each) executed before each example)
describe Stack do
  context "when empty" do
    before(:each) do
      @stack = Stack.new
    end
  end
end

################################################################################
# helper methods
describe Thing do
  def create_thing(options)
    thing = Thing.new
    thing.set_status(options[:status])
    thing
  end
end

describe Thing do
  def given_thing_with(options)
    yield Thing.new do |thing|
      thing.set_status(options[:status])
    end
  end

  it "should do something when ok" do
    given_thing_with(:status => 'ok') do |thing|
      thing.do_fancy_stuff(1, true, :move => 'left', :obstacles => nil)
    end
  end
end

################################################################################
# helper modules
module UserExampleHelpers
  def create_valid_user
    User.new(:email => 'email@example.com', :password => 'shhhhh')
  end
end

describe User do
  include UserExampleHelpers
  it "does something when it is valid" do
    user = create_valid_user
  end
end

# or include in all example groups
RSpec.configure do |config|
  config.include(UserExampleHelpers)
end

################################################################################
# shared examples
# spec/support/shared_examples.rb
shared_examples_for "a phone field" do
  it "has 10 digits" do
    Business.new(phone_field => '8004567890').should
      have(:no).errors_on(phone_field)
  end
end

describe "phone" do
  let(:phone_field) { :phone }
  it_should_behave_like "a phone field"
end

################################################################################
# let (instead of instance variables in before block)
let(:blog_post) { BlogPost.create :title => 'Hello' }
let!(:comment) { blog_post.comments.create :text => 'first post' }

################################################################################
# specify (generated descriptions)
# instead of repeating expectation with: it "should not be published"...)
specify { blog_post.should_not be_published }

################################################################################
# subject (delegate should/should_not to subject)
subject { BlogPost.new :title => 'foo', :body => 'bar' }
 it "sets published timestamp" do
   subject.publish!
   subject.should be_published
 end

it { should be_valid }
its(:errors) { should be_empty }
its(:title) { should == 'foo' }
its(:body) { should == 'bar' }
its(:published_on) { should == Date.today }

################################################################################
# matchers
# be
target.should be
target.should be_true
target.should be_false
target.should be_nil
target.should_not be_nil
thing.should be # passes if thing is not nil or false
collection.should be_empty # passes if target.empty?
target.should_not be_empty # passes unless target.empty?
target.should_not be_under_age(16) # passes unless target.under_age?(16)
user.should be_in_role("admin") # passes if user.in_role?("admin") returns true
result.should be_close(5.25, 0.005)

# be_a, be_an
"a string".should be_an_instance_of(String)
3.should be_a_kind_of(Fixnum)
3.should be_a_kind_of(Numeric)
3.should be_an_instance_of(Fixnum)
3.should_not be_instance_of(Numeric) #fails

# operators
result.should == 3
result.should =~ /some regexp/
result.should be < 7
result.should be <= 7
result.should be >= 7
result.should be > 7

# include
[1, 2, 3].should include(1)
[1, 2, 3].should_not include(4)
"foobar".should include("bar")
"foobar".should_not include("baz")

# have
{:foo => "foo"}.should have_key(:foo)
{:bar => "bar"}.should_not have_key(:foo)
"this string".should have(11).characters
[1, 2, 3].should have(3).items
schedule.should have(3).days # passes if schedule.days.length == 3
home_team.should have(9).players_on(field)  # delegates players_on to home_team
widget.should have(1).error_on(:name)
model.should have(:no).errors_on(:title)
model.should have(1).record
day.should have_exactly(24).hours
dozen_bagels.should have_at_least(12).bagels
internet.should have_at_most(2037).killer_social_networking_apps

# respond_to
list.should respond_to(:length)

# errors
lambda { Object.new.explode! }.should raise_error(NameError)

# when all else fails...
actual.should satisfy { |actual| block } # passes if block returns true

################################################################################
# expect
# for changes
expect { BlogPost.create :title => "Hello"}.to change { BlogPost.count }.by(1)
expect { seller.accept Offer.new(250_000) }.to change{agent.commission}.by(7_500)
expect { blog_post.publish! }.to change { blog_post.published_on }.from(nil).to(Date.today)
expect { subject.update_with_omniauth(omniauth) }.to_not change { subject.score }

# for errors
expect { do_something_risky }.to raise_error
expect { account.withdraw 75, :dollars }.to raise_error(/attempted to withdraw 75 dollars/)
expect { account.withdraw 75, :dollars }.to raise_error(InsufficientFundsError)

course = Course.new(:seats => 20)
20.times { course.register Student.new }
lambda {
  course.register Student.new
}.should throw_symbol(:course_full, 20)

################################################################################
# custom matcher dsl
# joe.reports_to?(beatrice).should be_true
joe.should report_to(beatrice)

RSpec::Matchers.define :report_to do |boss|
  match do |employee|
    employee.reports_to?(boss)
  end
end

################################################################################
# doubles/stubs/mocks (aliases)
# doubles/stubs: method stubs (stub(:method).and_return(data))
# mocks: expectations (should_receive...)
describe Statement do
  it "uses the customer's name in the header" do
    customer = double('customer')
    customer.stub(:name).and_return('Aslak')
    statement = Statement.new(customer)
    statement.generate.should =~ /^Statement for Aslak/
  end
end

# shortcut
customer = double('customer', :name => 'Aslak')

# null object
null_object = mock('null', :null_object => true)

# fakes
ages = double('ages')
ages.stub(:age_for) do |what|
  if what == 'drinking'
    21
  elsif what == 'voting'
    18
  end
end

# stub chains
article = double()
Article.stub_chain(:recent, :published, :authored_by).and_return(article)

# partial stubbing/mocking
describe WidgetsController do
  describe "PUT update with valid attributes" do
    # partial stubbing
    it "redirects to the list of widgets" do
      widget = Widget.new()
      Widget.stub(:find).and_return(widget)
      widget.stub(:update_attributes).and_return(true)
      put :update, :id => 37
      response.should redirect_to(widgets_path)
    end
    # partial mocking
    it "updates the widget's attributes" do
      widget = Widget.new()
      Widget.stub(:find).and_return(widget)
      widget.should_receive(:update_attributes).and_return(true)
      put :update, :id => 37
    end
  end
end

# expectations
echo = mock('echo')
echo.should_receive(:sound).with("hey").and_return("hey")
echo.should_receive(:sound).with("hey") { "hey" }
mock_account.should_receive(:withdraw).exactly(1).times
network_double.should_receive(:open_connection).at_most(5).times
network_double.should_receive(:open_connection).at_least(2).times
account_double.should_receive(:withdraw).once
account_double.should_receive(:deposit).twice
checking_account.should_receive(:transfer).with(50, savings_account)
source_account.should_receive(:transfer).with(target_account, instance_of(Fixnum))
source_account.should_receive(:transfer).with(anything(), 50)
source_account.should_receive(:transfer).with(any_args())
collaborator.should_receive(:message).with(no_args())
mock_account.should_receive(:add_payment_accounts).with(hash_including('Electric' => '123', 'Gas' => '234'))
mock_account.should_receive(:add_payment_accounts).with(hash_not_including('Electric' => '123', 'Gas' => '234'))
mock_atm.should_receive(:login).with(/.* User/)
network_double.should_not_receive(:open_connection)
network_double.should_receive(:open_connection).never

# ordering (ensure count is called before add)
database.should_receive(:count).with('Roster', :course_id => 37).ordered
database.should_receive(:add).with(student).ordered

# errors
account_double.should_receive(:withdraw).and_raise
account_double.should_receive(:withdraw).and_raise(InsufficientFunds)
account_double.should_receive(:withdraw).and_throw(:insufficient_funds)

# custom argument matchers
class GreaterThanMatcher
  def initialize(expected)
    @expected = expected
  end

  def description
    "a number greater than #{@expected}"
  end

  def ==(actual)
    actual > @expected
  end
end

def greater_than(floor)
  GreaterThanMatcher.new(floor)
end

calculator.should_receive(:add).with(greater_than(37))