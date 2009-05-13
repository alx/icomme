require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a attribute exists" do
  request(resource(:attributes), :method => "POST", 
    :params => { :attribute => { :id => nil }})
end

describe "resource(:attributes)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:attributes))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of attributes" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a attribute exists" do
    before(:each) do
      @response = request(resource(:attributes))
    end
    
    it "has a list of attributes" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      @response = request(resource(:attributes), :method => "POST", 
        :params => { :attribute => { :id => nil }})
    end
    
    it "redirects to resource(:attributes)" do
    end
    
  end
end

describe "resource(@attribute)" do 
  describe "a successful DELETE", :given => "a attribute exists" do
     before(:each) do
       @response = request(resource(Attribute.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:attributes))
     end

   end
end

describe "resource(:attributes, :new)" do
  before(:each) do
    @response = request(resource(:attributes, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@attribute, :edit)", :given => "a attribute exists" do
  before(:each) do
    @response = request(resource(Attribute.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@attribute)", :given => "a attribute exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Attribute.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @attribute = Attribute.first
      @response = request(resource(@attribute), :method => "PUT", 
        :params => { :attribute => {:id => @attribute.id} })
    end
  
    it "redirect to the attribute show action" do
      @response.should redirect_to(resource(@attribute))
    end
  end
  
end

