import React, { useState } from 'react';
import { StyleSheet, Text, View, Button, TextInput } from 'react-native';

import Header from './components/Header';
import DaysScreen from './screens/DaysScreen';

let content = <DaysScreen />;

export default function App() {
  return (
    <View style={styles.container}>
      <Header title="A M A" />
      {content}
    </View>
  );
}




const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'cyan'
  }
});
