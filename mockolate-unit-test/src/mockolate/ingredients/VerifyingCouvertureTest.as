package mockolate.ingredients
{
    import mockolate.ingredients.faux.FauxInvocation;
    import mockolate.verify;
    
    import org.flexunit.assertThat;
    import org.hamcrest.collection.array;
    import org.hamcrest.collection.emptyArray;
    
    use namespace mockolate_ingredient;
    
    public class VerifyingCouvertureTest
    {
    	public var mockolate:Mockolate;
    	public var verifier:VerifyingCouverture;
    	
    	[Before]
    	public function create():void 
    	{
    		this.mockolate = new Mockolate();
    		verifier = new VerifyingCouverture(this.mockolate);
    		
    		verifier.invoked(invocation({ name: "method", arguments: [] }));
    		verifier.invoked(invocation({ name: "method", arguments: [1, 2, 3] }));
    		verifier.invoked(invocation({ name: "getter", invocationType: InvocationType.GETTER }));
    		verifier.invoked(invocation({ name: "setter", invocationType: InvocationType.SETTER, arguments: [4] }));
    	}
    	
    	protected function invocation(options:Object):Invocation 
    	{
    		return new FauxInvocation(options);
    	}
    	
    	[Test]
    	public function method():void 
    	{
    		verifier.method("method");
    		verifier.method("method").twice();
    	}
    	
        [Test]
        public function method_withEmptyArgs():void
        {
            
            verifier.method("method").noArgs();
            verifier.method("method").noArgs().once();
        }
        
        [Test]
        public function method_withArgs():void
        {
            verifier.method("method").args(1, 2, 3);
            verifier.method("method").args(1, 2, 3).once();
        }
        
        [Test]
        public function getter():void 
        {
        	verifier.getter("getter");
        	verifier.getter("getter").once();
        }
        
        [Test]
        public function setter():void 
        {
        	verifier.setter("setter");
        	verifier.setter("setter").once()
        	verifier.setter("setter").arg(4);
        	verifier.setter("setter").arg(4).once();
        }
        
        [Test]
        public function never():void 
        {
        	verifier.method("notCalled").never();
        }
    }
}