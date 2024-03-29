import Image from "next/image";
import Navbar from "./components/navbar";
import Header from "./components/header";

const IndexPage = () => {
  return (
    <div>
      <Navbar />
      <Header /> 
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <img src="homepage_bottom.png" alt="Homepage image" style={{ width: '900px', height: 'auto' }}/>
      </div>
    </div>

  );
};

export default IndexPage;